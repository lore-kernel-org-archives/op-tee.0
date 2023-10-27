From: "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/3] crypto: ccp - Add function to allocate and free
 memory using DMA APIs
Date: Fri, 27 Oct 2023 19:05:17 +0530
Message-ID: <94059f5c-10dd-4d75-a69c-76b21ff49546@amd.com>
In-Reply-To: <ZTtJdU5a/P4kg/Ss@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7244896859614990681=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7244896859614990681==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


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

Can you please elaborate a bit more? Is it because in the presence of IOMMU,
a contiguous DMA or bus-address-space "buffer" may be mapped non-contiguously
into the physical address space? As a result, for buffers larger than a page
size, when PSP tries to map the physical address into it's address space, the
PSP Trusted OS will not be able to read back the entire buffer data.

                CPU                  CPU                  Bus
              Virtual              Physical             Address
              Address              Address               Space
               Space                Space

             +-------+             +------+             +------+
             |       |             |MMIO  |   Offset    |      |
             |       |  Virtual    |Space |   applied   |      |
           C +-------+ --------> B +------+ ----------> +------+ A
             |       |  mapping    |      |   by host   |      |
   +-----+   |       |             |      |   bridge    |      |   +--------+
   |     |   |       |             +------+             |      |   |        |
   | CPU |   |       |             | RAM  |             |      |   | Device |
   |     |   |       |             |      |             |      |   |        |
   +-----+   +-------+             +------+             +------+   +--------+
             |       |  Virtual    |Buffer|   Mapping   |      |
           X +-------+ --------> Y +------+ <---------- +------+ Z
             |       |  mapping    | RAM  |   by IOMMU
             |       |             |      |
             |       |             |      |
             +-------+             +------+

Reference diagram from: 
https://www.kernel.org/doc/Documentation/DMA-API-HOWTO.txt


Regards,

Jeshwanth

>

--===============7244896859614990681==--

